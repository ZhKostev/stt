class HealthController < ApplicationController
  def index
    check_pending_migrations
    head :ok, content_type: "text/html"
  end

  private

  def check_pending_migrations
    if ActiveRecord::Base.connection.migration_context.needs_migration?
      raise ActiveRecord::PendingMigrationError
    end
  end
end
