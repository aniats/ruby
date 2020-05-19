require_relative 'team.rb'
require_relative 'two_teams.rb'
require 'csv'

class TeamList
    include Enumerable
    def initialize
        @table = []
        @team_list = Hash.new(0)
    end

    def iterator_name
        array_only_names = @team_list.keys
        return array_only_names.each unless block_given?

        array_only_names.each do |team|
            yield team
        end
    end

    def iterator_score
        array_sorted_by_score = @team_list.sort_by(&:last)
        return array_sorted_by_score.each unless block_given?

        array_sorted_by_score.each do |team|
            yield team
        end
    end

    def get_iterator_and_print(iterator)
        iterator.each do |value|
            puts value.to_s
        end
    end

    def add(first_team, second_team)
        @table.push(TwoTeams.new(first_team, second_team))
        @team_list[first_team.team_name] += point_system(first_team.team_score, second_team.team_score)
        @team_list[second_team.team_name] += point_system(second_team.team_score, first_team.team_score)
    end

    def delete(name)
        @table.each do |teams|
            if teams.first_team.team_name == name
                @team_list[teams.second_team.team_name] -= point_system(teams.second_team.team_score, teams.first_team.team_score)
            elsif teams.second_team.team_name == name
                @team_list[teams.first_team.team_name] -= point_system(teams.first_team.team_score, teams.second_team.team_score)
            end
        end
        @team_list.delete(name)

        @table = @table.select { |teams| teams.first_team.team_name != name && teams.second_team.team_name != name }
    end

    def point_system(team_score, rival_score)
        if team_score > rival_score
            return 3
        elsif team_score == rival_score
            return 1
        else
            return 0
        end
    end

    def process_file
        CSV.foreach('stage.csv', headers: false) do |row|
            first_team = Team.new(row[0], row[2])
            second_team = Team.new(row[1],row[3])
            add(first_team, second_team)
        end
        @team_list = @team_list.sort.to_h
    end

    def print_everything
        puts "Table: "
        @table.each do |teams|
            puts "#{teams.first_team.to_s} --- #{teams.second_team.to_s}"
        end

        puts "Team List: "
        @team_list.each do |team|
            puts "#{team.to_s}"
        end
    end
end

tmp = TeamList.new()
tmp.process_file
tmp.print_everything

puts ""
tmp.delete('CHAOS')
tmp.print_everything

# passing iterator_name to get_iterator_and_print
# tmp.get_iterator_and_print(tmp.iterator_name)

# passing iterator_score to get_iterator_and_print
# tmp.get_iterator_and_print(tmp.iterator_score
