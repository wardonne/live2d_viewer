enum WebMessage {
  snapshot('snaphost'),
  video('video'),
  animations('animations'),
  clothes('clothes'),
  skins('skins');

  final String label;

  const WebMessage(this.label);
}
