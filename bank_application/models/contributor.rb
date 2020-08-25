# frozen_string_literal: true

Contributor = Struct.new(:id, :name, :surname, :patronymic, :account_number,
                         :deposit_type, :sum, :start_date,
                         :key_word, :last_date, keyword_init: true)
