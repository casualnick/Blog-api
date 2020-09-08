class ApplicationController < ActionController::API
    include ActionController::MimeResponds
    include ActionController::RequestForgeryProtection
    include Response
    include ExceptionHandler
    protect_from_forgery with: :exception, unless: -> { request.format.json? } 
end
