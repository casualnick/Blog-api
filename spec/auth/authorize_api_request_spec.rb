require 'rails_helper'

RSpec.describe AuthorizeApiRequest, type: :request do
    let(:user) { create(:user) }
    let!(:header) { { 'Authorization' => token_generator(user.id) } }
    subject(:invalid_request_obj) { described_class.new({}) }
    subject(:valid_request_obj) { described_class.new(header) }

    describe '#call' do
        
        context 'valid request' do
            it 'return user object' do
                result = valid_request_obj.call
                expect(result[:user]).to eq(user)
            end

        end
        
        context 'invalid request' do
            context 'when token is missing' do
                it 'raises missing token error' do
                    expect { invalid_request_obj.call }
                    .to raise_error(ExceptionHandler::MissingToken, 'Missing token')
                end
            end

            context 'invalid token' do
                subject(:invalid_request_obj) do
                    described_class.new('Authorization' => token_generator(5))
                end

                it 'raises Invalid token error' do
                    expect { invalid_request_obj.call }
                    .to raise_error(ExceptionHandler::InvalidToken, /Invalid token/)
                end

            end

            context 'expired token' do
                let(:header) { { 'Authorization' => expired_token_generator(user.id) } }
                subject(:request) { described_class.new(header) }

                it 'raises invalid token exxpired signature error' do
                    expect { valid_request_obj.call }
                    .to raise_error(
                        ExceptionHandler::InvalidToken,
                        /Signature has expired/
                    )
                end
            end
            
            context 'fake token ' do
                let(:header) { { 'Authorization' => 'foobar' } }
                subject(:invalid_request_obj) { described_class.new(header) }

                it 'raise JWT:DecodeError' do
                    expect { invalid_request_obj.call }
                    .to raise_error(
                        ExceptionHandler::InvalidToken,
                        /Not enough or too many segments/
                    )
                end
            end
        end
    end
end