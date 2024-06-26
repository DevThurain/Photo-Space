import 'dart:async';
import 'package:flutter/material.dart';

class AltLoadingScreen {
  AltLoadingScreen._internal();
  static final _singleton = AltLoadingScreen._internal();
  factory AltLoadingScreen.instance() => _singleton;

  StreamController<String>? _textController;
  OverlayEntry? _overlay;

  void show({required BuildContext context, required String text}) {
    _textController = StreamController();
    _textController?.add(text);

    final state = Overlay.of(context);

    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    _overlay = OverlayEntry(
      builder: (context) {
        return Material(
          color: Colors.black.withAlpha(150),
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: size.width * 0.8,
                maxHeight: size.height * 0.8,
                minWidth: size.width * 0.5,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      const CircularProgressIndicator(),
                      const SizedBox(height: 20),
                      StreamBuilder(
                        stream: _textController?.stream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              snapshot.data as String,
                              textAlign: TextAlign.center,
                              style:
                                  Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    state.insert(_overlay!);
  }

  void hide() {
    _textController?.close();
    _overlay?.remove();
  }
}
