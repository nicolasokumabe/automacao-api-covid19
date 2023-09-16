describe "GET /countries/search" do
  context "país específico (SEM CHAVE)" do
    before(:all) do
      @base_api = BaseApi.new
      @country_aleatorio = Lista_de_countries::COUNTRIES.sample
    end

    it "deve retornar um erro de chave API inválida" do
      allow_any_instance_of(BaseApi).to receive(:consulta_sem_chave).and_return(
        OpenStruct.new(
          code: 401,
          body: { "message" => "Invalid API key. Go to https://docs.rapidapi.com/docs/keys for more info." }.to_json,
        )
      )

      @resultado = @base_api.consulta_sem_chave("countries", "?search=#{@country_aleatorio}")
      parsed_response = JSON.parse(@resultado.body)

      expect(@resultado.code).to eq(401)
      expect(parsed_response).to include("message")
      expect(parsed_response["message"]).to eq("Invalid API key. Go to https://docs.rapidapi.com/docs/keys for more info.")
    end
  end
  context "campo vazio de país específico (SEM CHAVE)" do
    before(:all) do
      @base_api = BaseApi.new
    end

    it "deve retornar um erro de chave API inválida" do
      allow_any_instance_of(BaseApi).to receive(:consulta_sem_chave).and_return(
        OpenStruct.new(
          code: 401,
          body: { "message" => "Invalid API key. Go to https://docs.rapidapi.com/docs/keys for more info." }.to_json,
        )
      )

      @resultado = @base_api.consulta_sem_chave("countries", "?search=")
      parsed_response = JSON.parse(@resultado.body)

      expect(@resultado.code).to eq(401)
      expect(parsed_response).to include("message")
      expect(parsed_response["message"]).to eq("Invalid API key. Go to https://docs.rapidapi.com/docs/keys for more info.")
    end
  end
  context "campo incompleto de país específico (SEM CHAVE)" do
    before(:all) do
      @base_api = BaseApi.new
    end

    it "deve retornar um erro de chave API inválida" do
      allow_any_instance_of(BaseApi).to receive(:consulta_sem_chave).and_return(
        OpenStruct.new(
          code: 401,
          body: { "message" => "Invalid API key. Go to https://docs.rapidapi.com/docs/keys for more info." }.to_json,
        )
      )

      @resultado = @base_api.consulta_sem_chave("countries", "?search=m")
      parsed_response = JSON.parse(@resultado.body)

      expect(@resultado.code).to eq(401)
      expect(parsed_response).to include("message")
      expect(parsed_response["message"]).to eq("Invalid API key. Go to https://docs.rapidapi.com/docs/keys for more info.")
    end
  end
end
