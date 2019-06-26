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
        link = Link.new(link_params_to_create)
        if link.save

          LinkJob.perform_later link.url

          render json: {
            status: 'SUCCESS', message: 'Link saved', data: link.url
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

      def link_params_to_update
        params.permit(:title, :url, :short_url, :visites)
      end

    end
  end
end
