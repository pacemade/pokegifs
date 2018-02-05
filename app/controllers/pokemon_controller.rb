require 'pry'

class PokemonController < ApplicationController

  def index

  end

  def show
    res = HTTParty.get("http://pokeapi.co/api/v2/pokemon/#{params[:id]}/")
    body = JSON.parse(res.body)

    name = body["name"]
    id = body["id"]
    types = body["types"].map do |slot|
              slot["type"]["name"]
            end

    resgiphy = HTTParty.get("https://api.giphy.com/v1/gifs/search?api_key=#{ENV["GIPHY_KEY"]}&q=#{name}&rating=g")
    bodygiphy = JSON.parse(resgiphy.body)

    gif_url = bodygiphy["data"][0]["url"]

    render json: {
      name: name,
      id: id,
      types: types,
      gif_url: gif_url
    }

  end
end
