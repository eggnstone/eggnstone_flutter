import 'dart:html' as html; // ignore: avoid_web_libraries_in_flutter

class ClipboardTools
{
    static void setData(String text)
    {
        final textArea = html.TextAreaElement();
        html.document.body!.append(textArea);
        textArea.style.border = '0';
        textArea.style.margin = '0';
        textArea.style.padding = '0';
        textArea.style.opacity = '0';
        textArea.style.position = 'absolute';
        textArea.readOnly = true;
        textArea.value = text;
        textArea.select();
        html.document.execCommand('copy');
        textArea.remove();
    }
}
