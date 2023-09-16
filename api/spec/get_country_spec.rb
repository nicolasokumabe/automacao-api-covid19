describe "GET /countries/search" do
  context "país específico afetado pelo COVID-19" do
    before(:all) do
      @base_api = BaseApi.new
      @country_aleatorio = Lista_de_countries::COUNTRIES.sample
    end

    it "verifica o código de status da requisição GET" do
      @resultado = @base_api.consulta_chave("countries", "?search=#{@country_aleatorio}")
      expect(@resultado.code).to eq(200)
    end

    it "deve retornar o país correto na resposta" do
      @resultado = @base_api.consulta_chave("countries", "?search=#{@country_aleatorio}")
      expect(@resultado["response"]).to include(@country_aleatorio)
    end

    it "deve retornar um formato de resposta válido" do
      @resultado = @base_api.consulta_chave("countries", "?search=#{@country_aleatorio}")
      expect(@resultado.keys).to include(
        "get",
        "parameters",
        "errors",
        "results",
        "response"
      )
    end

    it "deve retornar 1 resultado" do
      @resultado = @base_api.consulta_chave("countries", "?search=#{@country_aleatorio}")
      expect(@resultado["results"]).to eq(1)
    end
  end

  context "campo vazio de país específico afetado pelo COVID-19" do
    before(:all) do
      @base_api = BaseApi.new
    end

    it "verifica o código de status da requisição GET" do
      @resultado = @base_api.consulta_chave("countries", "?search=")
      expect(@resultado.code).to eq(200)
    end

    it "deve retornar uma estrutura de resposta válida" do
      @resultado = @base_api.consulta_chave("countries", "?search=")
      expect(@resultado.keys).to include(
        "get",
        "parameters",
        "errors",
        "results",
        "response"
      )
    end

    it "deve retornar a mensagem de erro correta" do
      @resultado = @base_api.consulta_chave("countries", "?search=")
      expect(@resultado["errors"]["search"]).to eq("The search field cannot be empty.")
    end

    it "deve retornar 0 resultados" do
      @resultado = @base_api.consulta_chave("countries", "?search=")
      expect(@resultado["results"]).to eq(0)
    end

    it "deve retornar uma lista vazia na resposta" do
      @resultado = @base_api.consulta_chave("countries", "?search=")
      expect(@resultado["response"]).to be_empty
    end
  end

  context "campo incompleto de país específico afetado pelo COVID-19" do
    before(:all) do
      @base_api = BaseApi.new
    end

    it "deve retornar uma estrutura de resposta válida" do
      @resultado = @base_api.consulta_chave("countries", "?search=m")
      expect(@resultado.keys).to include(
        "get",
        "parameters",
        "errors",
        "results",
        "response"
      )
    end

    it "deve retornar a mensagem de erro correta" do
      @resultado = @base_api.consulta_chave("countries", "?search=m")
      expect(@resultado["errors"]["search"]).to eq("The Search field must be at least 3 characters in length.")
    end

    it "deve retornar 0 resultados" do
      @resultado = @base_api.consulta_chave("countries", "?search=m")
      expect(@resultado["results"]).to eq(0)
    end

    it "deve retornar uma lista vazia na resposta" do
      @resultado = @base_api.consulta_chave("countries", "?search=m")
      expect(@resultado["response"]).to be_empty
    end
  end
end
