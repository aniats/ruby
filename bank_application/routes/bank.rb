# frozen_string_literal: true

# Routes
class BankApplication
  path :bank, 'bank'
  path :contributors, '/bank/contributors'
  path :new_contributor, '/bank/new_contributor'
  path :compensation_for_interest, '/bank/compensation_for_interest'
  path :close_account, '/bank/close_account'
  path :addition, '/bank/addition'
  path :most_popular_deposit, '/bank/most_popular_deposit'
  path :unique_contributors, '/bank/unique_contributors'
  path :deposits, '/bank/deposits'
  path :new_deposit, '/bank/new_deposit'
  path :delete_deposit, '/bank/delete_deposit'

  path Contributor do |contributor|
    "/bank/contributors/#{contributor.id}"
  end

  hash_branch('bank') do |r|
    append_view_subdir('bank')
    set_layout_options(template: '../views/layout')

    r.is do
      view('info')
    end

    r.on 'compensation_for_interest' do
      r.get do
        @parameters = {}
        view('compensation_for_interest')
      end

      r.post do
        @parameters = DryResultFormeWrapper.new(CompensationForInterestFormSchema.call(r.params))
        if @parameters.success?
          opts[:store].contributor_list.compensation_for_interest(r.params['date'])
          @contributors = opts[:store].contributor_list.all_contributors
          r.redirect('contributors')
        else
          view('compensation_for_interest')
        end
      end
    end

    r.on 'close_account' do
      r.get do
        @errors = []
        @parameters = {}
        view('close_account')
      end

      r.post do
        @parameters = DryResultFormeWrapper.new(CloseAccountFormSchema.call(r.params))
        @errors = []
        if @parameters.success?
          @errors = opts[:store].contributor_list.account_number?(r.params['account_number'])
          if @errors.empty?
            @info = opts[:store].contributor_list.close_account(r.params['account_number'],
                                                                r.params['date'])
            view('compensation_for_closed')
          else
            view('close_account')
          end
        else
          view('close_account')
        end
      end
    end

    r.on 'addition' do
      r.get do
        @errors = []
        @parameters = {}
        view('addition')
      end

      r.post do
        @parameters = DryResultFormeWrapper.new(AdditionFormSchema.call(r.params))
        @errors = []
        if @parameters.success?
          @errors = opts[:store].contributor_list.errors_possible_to_add(r.params['account_number'],
                                                                         r.params['surname'],
                                                                         r.params['key_word'])
          if @errors.empty?
            opts[:store].contributor_list.addition(r.params['account_number'], r.params['sum'])
            @contributors = opts[:store].contributor_list.all_contributors
            r.redirect('contributors')
          else
            view('addition')
          end
        else
          view('addition')
        end
      end
    end

    r.on 'most_popular_deposit' do
      @most_popular_deposit = opts[:store].contributor_list.most_popular_deposit
      view('most_popular_deposit')
    end

    r.on 'contributors' do
      r.is do
        @contributors = opts[:store].contributor_list.all_contributors
        view('contributors')
      end

      r.on Integer do |contributor_id|
        @contributor = opts[:store].contributor_list.contributor_by_id(contributor_id)
        next if @contributor.nil?

        r.is do
          view('contributor')
        end
      end
    end

    r.on 'unique_contributors' do
      @surnames = opts[:store].contributor_list.contributors_sorted_by_surname
      view('unique_contributors')
    end

    r.on 'new_contributor' do
      r.get do
        @parameters = {}
        @errors = []
        view('new_contributor')
      end

      r.post do
        @parameters = DryResultFormeWrapper.new(ContributorFormSchema.call(r.params))
        @errors = []
        if @parameters.success?
          @errors = opts[:store].deposit_list.check_if_deposit_exists(r.params['deposit_type'])
          if @errors.empty?
            deposit = opts[:store].deposit_list.get_deposit_info_by_name(r.params['deposit_type'])
            opts[:store].contributor_list.add_contributor(@parameters, deposit)
            @contributors = opts[:store].contributor_list.all_contributors
            r.redirect('contributors')
          else
            view('new_contributor')
          end
        else
          view('new_contributor')
        end
      end
    end

    r.on 'deposits' do
      @deposits = opts[:store].deposit_list.all_deposits
      view('deposits')
    end

    r.on 'new_deposit' do
      r.get do
        @parameters = {}
        view('new_deposit')
      end

      r.post do
        @parameters = DryResultFormeWrapper.new(DepositFormSchema.call(r.params))
        if @parameters.success?
          opts[:store].deposit_list.add_deposit(@parameters)
          @deposits = opts[:store].deposit_list.all_deposits
          r.redirect('deposits')
        else
          view('new_deposit')
        end
      end
    end

    r.on 'delete_deposit' do
      r.get do
        @errors = []
        @parameters = {}
        view('delete_deposit')
      end

      r.post do
        @parameters = DryResultFormeWrapper.new(DeleteDepositFormSchema.call(r.params))
        @errors = []
        if @parameters.success?
          @errors = opts[:store].deposit_list.check_if_deposit_exists(r.params['deposit_type'])
          if @errors.empty?
            @delete_deposit = opts[:store].contributor_list
                                          .delete_deposit_compensation(r.params['deposit_type'],
                                                                       r.params['date'])
            opts[:store].deposit_list.delete_deposit_by_name(r.params['deposit_type'])
            view('compensation_after_deleting_deposit')
          else
            view('delete_deposit')
          end
        else
          view('delete_deposit')
        end
      end
    end
  end
end
