require "httparty"
require "dotenv/load"
require_relative "env"

class BaseApi
  include HTTParty
  base_uri "https://covid-193.p.rapidapi.com"

  def consulta_chave(rotas, id = "")
    self.class.get(
      "/#{rotas}/#{id}",
      headers: {
        "X-RapidAPI-Key" => API_KEY,
      },
    )
  end

  def consulta_sem_chave(rotas, id = "")
    self.class.get(
      "/#{rotas}/#{id}"
    )
  end
end
