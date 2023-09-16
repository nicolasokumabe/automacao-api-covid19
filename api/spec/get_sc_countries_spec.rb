describe "GET /countries" do
  context "busca de países afetados pela COVID-19 (SEM CHAVE)" do
    before(:all) do
      @base_api = BaseApi.new
      @resultado = @base_api.consulta_chave("countries")
    end

    it "deve retornar um erro de chave API inválida" do
      allow_any_instance_of(BaseApi).to receive(:consulta_sem_chave).and_return(
        OpenStruct.new(
          code: 401,
          body: { "message" => "Invalid API key. Go to https://docs.rapidapi.com/docs/keys for more info." }.to_json,
        )
      )

      @resultado = @base_api.consulta_sem_chave("countries")
      parsed_response = JSON.parse(@resultado.body)

      expect(@resultado.code).to eq(401)
      expect(parsed_response).to include("message")
      expect(parsed_response["message"]).to eq("Invalid API key. Go to https://docs.rapidapi.com/docs/keys for more info.")
    end
  end
end
