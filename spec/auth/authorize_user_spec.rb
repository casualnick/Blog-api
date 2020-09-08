require 'rails_helper'

RSpec.describe AuthorizeUser do
    let(:user) { create(:user) }
    subject(:valid_request_obj) { described_class.new(user.email, user.password ) }
    subject(:invalid_request_obj) { described_class.new('not', 'valid' ) }

    describe '#call' do
        
        context 'valid user' do
            
            it 'return user s token' do
                token = valid_request_obj.call
                expect(token).not_to be_nil
            end

        end

        context 'invalid user ' do

            it 'return failure message invalid credential' do
                expect { invalid_request_obj.call }
                .to raise_error(
                    ExceptionHandler::AuthenticationError,
                    /Invalid credentials/
                )
            end
        end
    end


end