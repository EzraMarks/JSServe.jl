using JSServe

function create_link(parent, file)
    local_asset = JSServe.Asset(joinpath(parent, file))
    return JSServe.DOM.a(href=local_asset, file)
end

function test_handler(session, req)
    path = pwd()

    dom = JSServe.DOM.div([JSServe.DOM.div(create_link(path, file)) for file in readdir(path) if isfile(file)]...)

    return JSServe.DOM.div(dom)
end

isdefined(Main, :app) && close(app)
app = JSServe.Application(test_handler, "0.0.0.0", 8082)
