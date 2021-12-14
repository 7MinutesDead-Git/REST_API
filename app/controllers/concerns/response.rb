module Response
  def render_json_response(object, status = :ok)
    render(json: object, status: status)
  end
end