module UsersHelper

	def add_another_field(name, f, association)
		new_object = f.object.send(association).klass.new # build a new answer instance
		id = new_object.object_id # generate a unique 'id' for the object

		# build a fields_for instance for the new answer, passing in a builder
		fields = f.fields_for(association, new_object, child_index: id) do |builder|
			# render the '[view]_fields partial
			render(association.to_s.singularize + "_field", f: builder)
		end
		# generate a link to add more fields using js
		link_to(name, '#', class: "add_fields btn btn-info", data: {id: id, fields: fields.gsub("\n", "")})
	end

	def check_role
		if current_user.role == 'user'
			str =	'<p class="alert alert-warning alert-dismissible" role="alert">'
			str += '<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>'
			str += "Please complete your profile before continuing"
			str += '</p>'
			str.html_safe
		end
	end

	def other_conversation_participant(conversation)
		if conversation.initiator_id == current_user.id
			"#{User.find(conversation.recipient_id).name}"
		else
			"#{User.find(conversation.initiator_id).name}"
		end
	end

	def get_skill_title(user)
		(user.role == 'developer')? 'Technical Skills' : 'Experience'
	end

end