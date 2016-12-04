class NoteRepliesController < ApplicationController
  before_action :set_note_reply, only: %i(update destroy)

  ################# Documentation ##############################################
  api :POST, '/projects/:project_id/artboards/:artboard_id/notes', 'Returns the created notes or the errors'
  example <<-EOS
    {
      id:
      note:
      rect: {
        x:
        y:
      }
    }
  EOS
  param :artboard_id, Integer, desc: 'Artboard ID', required: true
  param :note, Hash, required: true do
    param :note, String, desc: 'Tag name', required: true
    param :rect, Hash, desc: 'Tag name', required: true do
      param :x, Integer, desc: 'X position', required: true
      param :y, Integer, desc: 'X position', required: true
    end
  end
  error code: 400, desc: 'Bad request, when empty note hash is passed'
  error code: 401, desc: 'Authentication failed'
  ################# /Documentation #############################################
  def create
    @note_reply = NoteReply.new(note_reply_params)

    if @note_reply.save
      render json: @note_reply, status: :created, location: @note_reply
    else
      render json: @note_reply.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /note_replies/1
  def update
    if @note_reply.update(note_reply_params)
      render json: @note_reply
    else
      render json: @note_reply.errors, status: :unprocessable_entity
    end
  end

  # DELETE /note_replies/1
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
      params.require(:note_reply).permit(:text, :note_id)
    end
end
