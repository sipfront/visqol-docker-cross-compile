# -*- coding: utf-8 -*-
# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: similarity_result.proto
"""Generated protocol buffer code."""
from google.protobuf import descriptor as _descriptor
from google.protobuf import descriptor_pool as _descriptor_pool
from google.protobuf import message as _message
from google.protobuf import reflection as _reflection
from google.protobuf import symbol_database as _symbol_database
# @@protoc_insertion_point(imports)

_sym_db = _symbol_database.Default()




DESCRIPTOR = _descriptor_pool.Default().AddSerializedFile(b'\n\x17similarity_result.proto\x12\x06Visqol\"\xe4\x03\n\x13SimilarityResultMsg\x12\x0e\n\x06moslqo\x18\x01 \x01(\x01\x12\r\n\x05vnsim\x18\x02 \x01(\x01\x12\x0e\n\x06\x66vnsim\x18\x03 \x03(\x01\x12\x10\n\x08\x66vnsim10\x18\x0b \x03(\x01\x12\x10\n\x08\x66stdnsim\x18\x08 \x03(\x01\x12\x13\n\x0b\x66vdegenergy\x18\t \x03(\x01\x12\x19\n\x11\x63\x65nter_freq_bands\x18\x04 \x03(\x01\x12\x42\n\npatch_sims\x18\x05 \x03(\x0b\x32..Visqol.SimilarityResultMsg.PatchSimilarityMsg\x12\x1a\n\x12reference_filepath\x18\x06 \x01(\t\x12\x19\n\x11\x64\x65graded_filepath\x18\x07 \x01(\t\x12\x17\n\x0f\x61lignment_lag_s\x18\n \x01(\x01\x1a\xb5\x01\n\x12PatchSimilarityMsg\x12\x12\n\nsimilarity\x18\x01 \x01(\x01\x12\x17\n\x0f\x66req_band_means\x18\x02 \x03(\x01\x12\x1c\n\x14ref_patch_start_time\x18\x03 \x01(\x01\x12\x1a\n\x12ref_patch_end_time\x18\x04 \x01(\x01\x12\x1c\n\x14\x64\x65g_patch_start_time\x18\x05 \x01(\x01\x12\x1a\n\x12\x64\x65g_patch_end_time\x18\x06 \x01(\x01\x62\x06proto3')



_SIMILARITYRESULTMSG = DESCRIPTOR.message_types_by_name['SimilarityResultMsg']
_SIMILARITYRESULTMSG_PATCHSIMILARITYMSG = _SIMILARITYRESULTMSG.nested_types_by_name['PatchSimilarityMsg']
SimilarityResultMsg = _reflection.GeneratedProtocolMessageType('SimilarityResultMsg', (_message.Message,), {

  'PatchSimilarityMsg' : _reflection.GeneratedProtocolMessageType('PatchSimilarityMsg', (_message.Message,), {
    'DESCRIPTOR' : _SIMILARITYRESULTMSG_PATCHSIMILARITYMSG,
    '__module__' : 'similarity_result_pb2'
    # @@protoc_insertion_point(class_scope:Visqol.SimilarityResultMsg.PatchSimilarityMsg)
    })
  ,
  'DESCRIPTOR' : _SIMILARITYRESULTMSG,
  '__module__' : 'similarity_result_pb2'
  # @@protoc_insertion_point(class_scope:Visqol.SimilarityResultMsg)
  })
_sym_db.RegisterMessage(SimilarityResultMsg)
_sym_db.RegisterMessage(SimilarityResultMsg.PatchSimilarityMsg)

if _descriptor._USE_C_DESCRIPTORS == False:

  DESCRIPTOR._options = None
  _SIMILARITYRESULTMSG._serialized_start=36
  _SIMILARITYRESULTMSG._serialized_end=520
  _SIMILARITYRESULTMSG_PATCHSIMILARITYMSG._serialized_start=339
  _SIMILARITYRESULTMSG_PATCHSIMILARITYMSG._serialized_end=520
# @@protoc_insertion_point(module_scope)
