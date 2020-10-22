import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.IOException;
import java.net.URL;
import java.util.Arrays;
import java.util.stream.StreamSupport;

public class WeatherForecast {
    private final static String REQUEST_URL = "https://api.openweathermap.org/data/2.5/onecall?lat=44.613648&lon=41.919462&appid=f2aaba00927b9e9f43aa7a20385345dc&units=metric&lang=ru&exclude=alerts,hourly,minutely";

    public static void main(String[] args) throws IOException {
        // получение JSON объекта с данными о погоде
        URL url = new URL(REQUEST_URL);
        ObjectMapper mapper = new ObjectMapper();
        JsonNode days = mapper.readTree(url).get("daily");

        // преобразование JSON-объекта ответа в массив значений температуры на первые 5 дней
        double[] temps = StreamSupport.stream(days.spliterator(), false)
                .limit(5)
                .map(node -> node.get("temp").get("morn").asDouble())
                .mapToDouble(Double::doubleValue)
                .toArray();

        // Вычисление среднего и максимального значений
        double avg = Arrays.stream(temps).average().getAsDouble();
        double max = Arrays.stream(temps).max().getAsDouble();

        System.out.printf("Средняя прогнозная утренняя температура: %.2f C\n", avg);
        System.out.printf("Максимальная прогнозная утренняя температура: %.2f C\n", max);
    }
}