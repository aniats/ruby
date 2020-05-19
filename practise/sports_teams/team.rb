class Team
    attr_reader :team_name, :team_score
    
    def initialize(team_name, team_score)
        @team_name = team_name
        @team_score = team_score.to_i
    end

    def to_s
        "#{@team_name} #{team_score.to_s}"
    end
end