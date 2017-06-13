require "rubygems"
require "rx_ruby"
require "net/http"

class WelcomeController < ApplicationController

  GITHUB_API_ENDPOINT = 'https://api.github.com/repos/'
  PER_PAGE = 5

  @@page_number = 1
  @@endpoint=""
  @response_array = []





  def index
    query = params[:repo]
    search_button = params[:search]
    @response_array ||= []
  end

  def search
    @response_array ||= []
    @@endpoint = params[:repos]
    if @@endpoint and @@page_number
        request_event
    end


  end

  def next
    @response_array ||= []
    @@page_number += 1
    request_event
  end

  def back
    @response_array ||= []
    if @@page_number > 1
      @@page_number -= 1
      request_event
    end
  end



  def request_event
    click_event = RxRuby::Observable.just(@@page_number)

    request_stream = click_event
        .map { |x| GITHUB_API_ENDPOINT+@@endpoint+"/issues?page=#{@@page_number}&per_page=#{PER_PAGE}"}

    response_stream = request_stream.map{ |request_url|
      response = Net::HTTP.get_response(URI.parse(request_url))
      if response.is_a?(Net::HTTPSuccess)
        response_json = JSON.parse(response.body)
      else
        response_json = []
      end
    }

    @response_array = []
    response_stream
        .subscribe{ |x| @response_array = x}

  end
end





