import 'package:flutter/material.dart';
import 'package:modul_1/providers/app_state.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();

    if (appState.favorites.isEmpty) {
      return const Center(
        child: Text('No favorites yet.'),
      );
    }

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text('You have '
              '${appState.favorites.length} favorites:'),
        ),
        for (var pair in appState.favorites)
          ListTile(
            leading: const Icon(Icons.favorite),
            title: Text(pair.asLowerCase),

            // Menambahkan IconButton yang berfungsi untuk menghapus item favorit
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                // Tampilkan dialog konfirmasi sebelum menghapus
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Hapus Favorit"),
                      content: Text("Apakah Anda yakin ingin menghapus ${pair.asPascalCase} dari favorit?"),
                      actions: <Widget>[
                        TextButton(
                          child: const Text("Batal"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text("Hapus"),
                          onPressed: () {
                            // Panggil metode untuk menghapus item dari favorit
                            appState.removeFavorite(pair);
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
      ],
    );
  }
}
