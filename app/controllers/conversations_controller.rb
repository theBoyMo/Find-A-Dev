class ConversationsController < ApplicationController

	def index
		@conversations = Conversation.get_user_conversations(current_user.id)
		@users = User.all_except(current_user)
    respond_to do |format|
      format.html
      format.json { render json: @conversations }
    end
	end

	def create
		@conversation = Conversation.find_or_create(current_user.id, conversation_params)
		if @conversation && @conversation.id.nil?
			@conversation.save
			redirect_to new_conversation_message_path(@conversation), notice: "Start a new conversation"
		elsif @conversation
			redirect_to conversation_messages_path(@conversation), alert: "Conversation ongoing"
		else
			redirect_to root_path, alert: "unable to find existing conversation or create a new one."
		end
	end

	private
		def conversation_params
			params.permit(:title, :recipient_id)
		end

end
