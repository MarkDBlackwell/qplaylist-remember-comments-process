# coding: utf-8

=begin
Author: Mark D. Blackwell (google me)
mdb March 24, 2018 - created
=end

dirname_file_current = ::Kernel.__dir__
lib = dirname_file_current
package = 'comments_process'
legs_ordered = %w[
    pure
    impure
    ]
branches = legs_ordered.map{|leaf| ::File.join lib, package, leaf}

branches.each do        |branch|
  real = ::File.realpath branch
  $LOAD_PATH.unshift real unless $LOAD_PATH.include? real
end
