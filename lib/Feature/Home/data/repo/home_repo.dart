import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/quran_audio_model.dart';
import 'dart:developer';

class HomeRepository {
  final SupabaseClient supabase;

  HomeRepository(this.supabase);

  Future<QuranAudioModel> getQuranAudio(int id) async {
    try {
      final response = await supabase
          .from('quran')
          .select()
          .eq('id', id)
          .single();
      print('response: $response');
      return QuranAudioModel.fromJson(response);
    } catch (e) {
      log('Error fetching Quran audio: $e');
      throw Exception('Failed to load Quran audio: $e');
    }
  }
}
