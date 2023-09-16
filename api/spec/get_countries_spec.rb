describe "GET /countries" do
  context "busca de países afetados pela COVID-19" do
    before(:all) do
      @base_api = BaseApi.new
      @resultado = @base_api.consulta_chave("countries")
      @lista_de_countries = Lista_de_countries::COUNTRIES
    end

    it "deve retornar o status code 200" do
      expect(@resultado["get"]).to eq("countries/")
      expect(@resultado["parameters"]).to be_empty
      expect(@resultado["errors"]).to be_empty
      expect(@resultado["results"]).to eq(@resultado["response"].count)
    end

    it "deve verificar a estrutura da resposta API" do
      expect(@resultado).to have_key("get")
      expect(@resultado).to have_key("parameters")
      expect(@resultado).to have_key("errors")
      expect(@resultado).to have_key("results")
      expect(@resultado).to have_key("response")
    end

    it "deve verificar o número de países" do
      expect(@resultado["results"]).to eq(@resultado["response"].count)
    end

    it "verifica se os países da lista estão presentes na resposta da API" do
      api_countries = @resultado["response"]

      @lista_de_countries.each do |country|
        expect(api_countries).to include(country)
      end
    end
  end
end
