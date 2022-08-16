import 'dart:convert';

Format formatFromJson(String str) => Format.fromJson(json.decode(str));

String formatToJson(Format data) => json.encode(data.toJson());

class Format {
  final String? image;
  final String? textHtml;
  final String? textHtmlUtf8;
  final String? textPlainUtf8;
  final String? mobipocketEbook;
  final String? rdfXml;
  final String? epubZip;
  final String? zip;
  final String? octetStream;

  const Format({
    this.image,
    this.textHtml,
    this.textHtmlUtf8,
    this.textPlainUtf8,
    this.mobipocketEbook,
    this.rdfXml,
    this.epubZip,
    this.zip,
    this.octetStream,
  });

  factory Format.fromJson(Map<String, dynamic> json) => Format(
    image: json['image/jpeg'] as String?,
    textHtml: json['text/html'] as String?,
    textHtmlUtf8: json['text/html; charset=utf-8'] as String?,
    textPlainUtf8: json['text/plain; charset=utf-8'] as String?,
    mobipocketEbook: json['application/x-mobipocket-ebook'] as String?,
    rdfXml: json['application/rdf+xml'] as String?,
    epubZip: json['application/epub+zip'] as String?,
    zip: json['application/zip'] as String?,
    octetStream: json['application/octet-stream'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'image/jpeg': image,
    'text/html': textHtml,
    'text/html; charset=utf-8': textHtmlUtf8,
    'text/plain; charset=utf-8': textPlainUtf8,
    'application/x-mobipocket-ebook': mobipocketEbook,
    'application/rdf+xml': rdfXml,
    'application/epub+zip': epubZip,
    'application/zip': zip,
    'application/octet-stream': octetStream,
  };
}
