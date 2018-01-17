class CreateForkHistoryView < ActiveRecord::Migration
  def self.up
    execute <<-SQL
      CREATE  VIEW fork_histories AS
        with recursive forkedFrom as (
      
          select
            *,
            array[id] as path
          from recipes
          where
            fork_origin_id is null
      
          union all
      
          select
            recipes.*,
            forkedFrom.path || recipes.id as path
          from recipes
          join forkedFrom on recipes.fork_origin_id = forkedFrom.id
        )
      
        select
          *
        from forkedFrom
        order by
          id;
    SQL
  end

  def self.down
    execute "DROP VIEW fork_histories"
  end
end
