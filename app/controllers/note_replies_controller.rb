class NoteRepliesController < ApplicationController
  before_action :set_note_reply, only: %i(update destroy)

  ################# Documentation ##############################################
  api :POST, '/projects/:project_id/artboards/:artboard_id/notes/:note_id/note_replies', 'Returns the created notes or the errors'
  example <<-EOS
    {
      id:
      note_id:
      text:
    }
  EOS
  param :artboard_id, Integer, desc: 'Artboard ID', required: true
  param :note_id, Integer, desc: 'The parent note ID', required: true
  param :user_id, Integer, desc: 'The ID of the user that created the reply', required: true
  param :text, String, desc: 'The reply content', required: true
  error code: 400, desc: 'Bad request, when empty note hash is passed'
  error code: 401, desc: 'Authentication failed'
  ################# /Documentation #############################################
  def create
    @note_reply = NoteReply.new(note_reply_params)

    if @note_reply.save
      render json: @note_reply.decorate.to_json, status: :created
    else
      render json: @note_reply.errors, status: :unprocessable_entity
    end
  end

  ################# Documentation ##############################################
  api :PUT, '/projects/:project_id/artboards/:artboard_id/notes/:note_id/note_replies', 'Returns the created notes or the errors'
  example <<-EOS
    {
      id:
      note_id:
      text:
    }
  EOS
  param :artboard_id, Integer, desc: 'Artboard ID', required: true
  param :note_id, Integer, desc: 'The parent note ID', required: true
  param :text, String, desc: 'The reply content', required: true
  error code: 400, desc: 'Bad request, when empty note hash is passed'
  error code: 401, desc: 'Authentication failed'
  ################# /Documentation #############################################
  def update
    if @note_reply.update(note_reply_params)
      render json: @note_reply.decorate.to_json
    else
      render json: @note_reply.errors, status: :unprocessable_entity
    end
  end

  ################# Documentation ##############################################
  api :DELETE, '/projects/:project_id/artboards/:artboard_id/notes/:note_id/note_replies', 'Returns the created notes or the errors'
  example <<-EOS
    {
      id:
      note_id:
      text:
    }
  EOS
  param :artboard_id, Integer, desc: 'Artboard ID', required: true
  param :note_id, Integer, desc: 'The parent note ID', required: true
  param :text, String, desc: 'The reply content', required: true
  error code: 400, desc: 'Bad request, when empty note hash is passed'
  error code: 401, desc: 'Authentication failed'
  ################# /Documentation #############################################
  def destroy
    @note_reply.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note_reply
      @note_reply = NoteReply.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def note_reply_params
      params.permit(:text, :note_id, :user_id)
    end
end
