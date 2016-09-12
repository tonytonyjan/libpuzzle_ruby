# frozen_string_literal: true
require 'mkmf'
have_library('puzzle')
have_header('puzzle.h')
create_makefile('puzzle_ext')
