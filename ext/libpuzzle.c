#include <stddef.h>
#include <puzzle.h>
#include "ruby.h"

VALUE rb_cPuzzle, rb_eError;

typedef struct Puzzle{
  PuzzleContext context;
  PuzzleCvec vector;
} Puzzle;

static void free_puzzle(Puzzle *puzzle){
  puzzle_free_cvec(&puzzle->context, &puzzle->vector);
  puzzle_free_context(&puzzle->context);
}

static VALUE new(VALUE klass, VALUE file_path){
  Puzzle *puzzle;
  VALUE ret = Data_Make_Struct(klass, Puzzle, 0, free_puzzle, puzzle);
  puzzle_init_context(&puzzle->context);
  puzzle_init_cvec(&puzzle->context, &puzzle->vector);

  if(puzzle_fill_cvec_from_file(&puzzle->context, &puzzle->vector, StringValueCStr(file_path)) < 0)
    rb_raise(rb_eError, "failed to open file");

  VALUE rb_vector = rb_str_new((const char*)puzzle->vector.vec, puzzle->vector.sizeof_vec);

  rb_iv_set(ret, "@vector", rb_vector);
  return ret;
}

static double _distance(VALUE p1, VALUE p2){
  Puzzle *puzzle_1, *puzzle_2;
  Data_Get_Struct(p1, Puzzle, puzzle_1);
  Data_Get_Struct(p2, Puzzle, puzzle_2);
  double dist = puzzle_vector_normalized_distance(&puzzle_1->context, &puzzle_1->vector, &puzzle_2->vector, 1);
  if(dist < 0) rb_raise(rb_eError, "failed to compare vectors");
  return dist;
}

static VALUE distance(VALUE p1, VALUE p2){
  return rb_float_new(_distance(p1, p2));
}

static VALUE equal(VALUE p1, VALUE p2){
  return _distance(p1, p2) < 0.6 ? Qtrue : Qfalse;
}

static VALUE compress(VALUE self){
  Puzzle *puzzle;
  PuzzleCompressedCvec c_cvec;
  Data_Get_Struct(self, Puzzle, puzzle);
  puzzle_init_compressed_cvec(&puzzle->context, &c_cvec);

  puzzle_compress_cvec(&puzzle->context, &c_cvec, &puzzle->vector);
  VALUE ret = rb_str_new((const char*)c_cvec.vec, c_cvec.sizeof_compressed_vec);
  puzzle_free_compressed_cvec(&puzzle->context, &c_cvec);
  return ret;
}

static VALUE uncompress(VALUE klass, VALUE compressed_string){
  Puzzle *puzzle;
  PuzzleCompressedCvec c_cvec;

  VALUE ret = Data_Make_Struct(klass, Puzzle, 0, free_puzzle, puzzle);
  puzzle_init_context(&puzzle->context);
  puzzle_init_cvec(&puzzle->context, &puzzle->vector);
  c_cvec.vec = (unsigned char*)RSTRING_PTR(compressed_string);
  c_cvec.sizeof_compressed_vec = RSTRING_LEN(compressed_string);

  puzzle_uncompress_cvec(&puzzle->context, &c_cvec, &puzzle->vector);

  VALUE rb_vector = rb_str_new((const char*)puzzle->vector.vec, puzzle->vector.sizeof_vec);
  rb_iv_set(ret, "@vector", rb_vector);
  return ret;
}

void Init_puzzle_ext(void){
  rb_cPuzzle = rb_define_class("Puzzle", rb_cObject);
  rb_eError = rb_define_class_under(rb_cPuzzle, "Error", rb_eRuntimeError);

  rb_define_attr(rb_cPuzzle, "vector", 1, 0);
  rb_define_singleton_method(rb_cPuzzle, "new", new, 1);
  rb_define_singleton_method(rb_cPuzzle, "uncompress", uncompress, 1);
  rb_define_method(rb_cPuzzle, "distance", distance, 1);
  rb_define_method(rb_cPuzzle, "==", equal, 1);
  rb_define_method(rb_cPuzzle, "compress", compress, 0);
}