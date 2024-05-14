import 'package:flutter/material.dart';

class ProfileTile extends StatefulWidget {
  const ProfileTile({
    super.key,
    required this.label,
    required this.text,
    required this.editable,
    this.onChanged,
  });

  final String label;
  final String text;
  final bool editable;
  final ValueChanged<String>? onChanged;

  @override
  State<ProfileTile> createState() => _ProfileTileState();
}

class _ProfileTileState extends State<ProfileTile> {
  bool _editing = false;
  TextEditingController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.text);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Text(
            widget.label,
          ),
          if (!_editing) ...[
            const Spacer(),
            Text(widget.text),
          ] else
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: _controller,
                  onSubmitted: (text) {
                    setState(() {
                      _editing = false;
                    });
                    if (text.trim() != widget.text) {
                      widget.onChanged?.call(
                        text.trim(),
                      );
                    }
                  },
                ),
              ),
            ),
          if (widget.editable)
            IconButton(
              onPressed: () => setState(() {
                _editing = !_editing;
              }),
              icon: Icon(_editing ? Icons.cancel : Icons.edit),
            ),
        ],
      ),
    );
  }
}
