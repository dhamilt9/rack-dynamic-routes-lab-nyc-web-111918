class Application


  def item(name)
    @@items.find{|list_item| list_item.name==name}
  end
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)
    if req.path.match(/items/)
      item_name=req.path.split("/items/").last
      if item(item_name)
        resp.write item(item_name).price
      else
        resp.write "Item not found"
        resp.status=400
      end
    else
      resp.write "Route not found"
      resp.status=404
    end

    resp.finish
  end
end
