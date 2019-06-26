module Api
  module V1
    class LinksController < ApplicationController
      def index
        links = Link.order('visites DESC').limit(100)
        render json: {
          status: 'SUCCESS',
          message: 'Loaded Links',
          data: links
        }, status: :ok
      end

      def show
        @link = Link.find_by(short_url: params[:id])
        if @link.present?
          aument = @link.visites
          Link.update(@link.id, visites: (aument + 1))
          redirect_to @link.url, status: 301
        else
          render json: {
            status: 'ERROR', message: 'Link does not exist', data: link
          }, status: :unprocessable_entity
        end
      end

      def create
        shorted = get_fake
        long = link_params_to_create
        if long.present?
          link = Link.new(url: long['url'], short_url: shorted)
        else
          render json: {
            status: 'ERROR', message: 'Link not saved', data: link
          }, status: :unprocessable_entity
        end
        if link.save
          LinkJob.perform_later link.url
          render json: {
            status: 'SUCCESS', message: 'Link saved', data: link.short_url
          }, status: :ok
        else
          render json: {
            status: 'ERROR', message: 'Link not saved', data: link
          }, status: :unprocessable_entity
        end
      end

      private

      def link_params_to_create
        params.permit(:url)
      end

      def get_fake
        fake = ''
        while true
          fake = Faker::Alphanumeric.alphanumeric(10)
          link = Link.find_by(short_url: fake)
          if !link.present?
            break
          end
        end
        return fake
      end
    end
  end
end
