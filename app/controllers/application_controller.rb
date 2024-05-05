class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :check_buffet_completion

    private 

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:is_buffet_owner, :name, :cpf])
    end
  
    def check_buffet_completion
      return unless current_user&.is_buffet_owner?
    
      unless (controller_name == 'buffets' && (action_name == 'new' || action_name == 'create')) ||
             (controller_name == 'sessions' && action_name == 'destroy')
        if current_user.buffet.nil?
          redirect_to new_buffet_path, alert: 'Agora só falta cadastrar o seu buffet!'
        end
      end
    end
    
end
