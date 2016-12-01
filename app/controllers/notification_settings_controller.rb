class NotificationSettingsController < ApplicationController
  before_action :set_notification_setting, only: %i(show update)

  ################# Documentation ##############################################
  api :GET, '/users/:user_id/notification_settings/:id', 'Returns the specified notification setting'
  example <<-EOS
    {
      summary:
      mention_me:
      create_project:
      weekly_summary:
      project_comment:
      new_features:
    }
  EOS
  param :user_id, Integer, desc: 'User ID', required: true
  error code: 404, desc: 'Notification setting not found'
  ################# /Documentation #############################################
  def show
    render json: @notification_setting
  end

  ################# Documentation ##############################################
  api :PUT, '/users/:user_id/notification_settings/:id', 'Returns the specified notification setting'
  example <<-EOS
    {
      summary:
      mention_me:
      create_project:
      weekly_summary:
      project_comment:
      new_features:
    }
  EOS
  param :user_id, Integer, desc: 'User ID', required: true
  param :notification_setting, Hash, desc: 'NotificationSetting data', required: true do
    param :summary, [true, false], desc: 'Email summary', required: false
    param :mention_me, [true, false], desc: 'Mention the user', required: false
    param :create_project, [true, false], desc: 'Create project email', required: false
    param :weekly_summary, [true, false], desc: 'Weekly email', required: false
    param :project_comment, [true, false], desc: 'Project email', required: false
    param :new_features, [true, false], desc: 'New features email', required: false
  end
  error code: 404, desc: 'Notification setting not found'
  ################# /Documentation #############################################
  def update
    if @notification_setting.update(notification_setting_params)
      render json: @notification_setting
    else
      render json: @notification_setting.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_notification_setting
      user = User.find(params[:user_id])
      @notification_setting = user.notification_setting

      return render json: {errors: ['Notification setting is not found!']}, status: 404 unless @notification_setting
    end

    # Only allow a trusted parameter "white list" through.
    def notification_setting_params
      params.require(:notification_setting).permit(:summary, :mention_me, :create_project,
                                                   :weekly_summary, :project_comment, :new_features)
    end
end
