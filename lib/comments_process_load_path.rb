# coding: utf-8

=begin
Author: Mark D. Blackwell (google me)
mdb March 24, 2018 - created
=end

dirname_file_current = ::Kernel.__dir__
lib = dirname_file_current
package = 'comments_process'
%w[pure impure].each do |leaf|
  branch = ::File.join lib, package, leaf
  real = ::File.realpath branch
  $LOAD_PATH.unshift real unless $LOAD_PATH.include? real
end
