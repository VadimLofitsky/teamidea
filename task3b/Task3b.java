import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

import javax.xml.parsers.DocumentBuilderFactory;
import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.net.URL;
import java.nio.charset.Charset;
import java.text.NumberFormat;
import java.util.Locale;
import java.util.NoSuchElementException;

public class Task3b {
    final static String REQUEST_URL = "http://cbr.ru/scripts/xml_daily.asp";

    public static void main(String[] args) throws Exception {
        // получение XML-документа
        URL url = new URL(REQUEST_URL);
        InputStream in = url.openStream();
        InputStreamReader isr = new InputStreamReader(in, Charset.forName("windows-1251"));
        BufferedReader reader = new BufferedReader(isr);
        String xml = reader.lines().reduce(String::concat).get();

        // парсинг текстового представления XML в org.w3c.dom.Document
        // и получение корневого элемента
        StringReader characterStream = new StringReader(xml);
        InputSource is = new InputSource(characterStream);
        Element root = DocumentBuilderFactory.newInstance()
                .newDocumentBuilder()
                .parse(is)
                .getDocumentElement();

        double nominal = 0, value = Double.NaN;

        // список элементов с описаниями и курсами валют
        NodeList valutes = root.getElementsByTagName("Valute");

        for (int i = 0; i < valutes.getLength(); i++) {
            // поиск элемента Valute, содержащего элемент <CharCode>HKD</CharCode>
            Node valute = valutes.item(i);
            NodeList valuteData = valute.getChildNodes();
            Node charcodeNode = getElFromListByName("charcode", valuteData);
            if (charcodeNode != null) {
                String charcode = charcodeNode.getTextContent();
                if ("HKD".equalsIgnoreCase(charcode)) {
                    // получение значений элементов Nominal и Value
                    String nominalText = getElFromListByName("nominal", valuteData).getTextContent();
                    String valueText = getElFromListByName("value", valuteData).getTextContent();

                    // учёт формата записи дробных чисел с десятичной запятой
                    NumberFormat format = NumberFormat.getInstance(Locale.getDefault());
                    nominal = format.parse(nominalText).doubleValue();
                    value = format.parse(valueText).doubleValue();

                    if (Double.isFinite(nominal) && Double.isFinite(value)) {
                        break;
                    } else {
                        String error = "Incorrect values 'nominal' and 'value' (" + nominalText + " and " + valueText + ")";
                        throw new IllegalArgumentException(error);
                    }
                }
            }
        }

        if (Double.isNaN(value)) {      // value не изменено, следовательно, поиск не дал результатов
            throw new NoSuchElementException("Couldn't find value data");
        }

        // вывод результата
        System.out.printf("Курс гонконгского доллара к рублю = %.4f (RUB / HKD)", nominal / value);
    }

    // поиск элемента по имени в списке NodeList
    static Node getElFromListByName(String name, NodeList list) {
        for (int i = 0; i < list.getLength(); i++) {
            Node node = list.item(i);
            if (node.getNodeName().equalsIgnoreCase(name)) {
                return node;
            }
        }
        return null;
    }
}