# frozen_string_literal: true

class RocketfuelApi::Resource
  def initialize(json, service)
    @json = json
    @service = service
  end

  def update(route_params = {}, body_params = {})
    resource = @service.update(id, route_params, body_params)
    @json = resource.raw_json

    self
  end

  def delete(route_params = {})
    @service.delete(id, route_params)
  end

  def raw_json
    @json
  end

  def method_missing(sym, *args, &block)
    if @json.respond_to?(sym)
      @json.public_send(sym, *args, &block)
    elsif @json.key?(sym.to_s)
      @json[sym.to_s]
    else
      super
    end
  end

  def respond_to_missing?(method_name, include_private = false)
    @json.respond_to?(sym) || @json.key?(sym.to_s) || super
  end

  def to_s
    @json.inspect
  end
end
