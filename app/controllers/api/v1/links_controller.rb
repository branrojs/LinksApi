module Api
  module V1
    class LinksController < ApplicationController
      def index
        links = Link.order('visites DESC')
        render json: {
                        status: 'SUCCESS',
                        message: 'Loaded Links',
                        data: links
                     }, status: :ok
      end

      def show
        link = Link.find(params[:id])
        render json: {
          status: 'SUCCESS',
          message: 'Loaded Link',
          data: link
       }, status: :ok
      end

      def create
        link = Link.new(link_params)

        if link.save
          render json: {
            status: 'SUCCESS',
            message: 'Link saved',
            data: link
                       }, status: :ok
        else
          render json: {
            status: 'ERROR',
            message: 'Link not saved',
            data: link
                       }, status: :unprocessable_entity
        end
      end

      private

      def link_params
        params.permit(:title, :URL, :SURL, :visits)
      end
    end
  end
end
