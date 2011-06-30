module ActionView
  class PathSet
    def typecast!
      each_with_index do |path, i|
        path = path.to_s if path.is_a?(Pathname)
        path = 'spec/test_app/' + path if path =~ /^[^\/]/ # look in the spec/test_app/
        next unless path.is_a?(String)
        self[i] = FileSystemResolver.new(path)
      end
    end
  end
end
