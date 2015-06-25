package dashboard

import grails.converters.JSON
import org.codehaus.groovy.grails.web.json.JSONObject
import org.codehaus.groovy.grails.web.json.parser.JSONParser

class MainController {

    def index() {

    }

    def search() {
        render(view:"search")
    }

    def getKeyword() {
        def keywords = []
        def raw = JSON.parse(grailsApplication.mainContext.getResource("overall.json").file.text)
        int count = 0
        raw.each { Map<String,String> m ->
            if (count < 30) {
                String w
                m.each {w = it.key}
                keywords.add(w)
            }
            count++
        }

        def model = ["relatedWords" : keywords]

        render(view:"keywordView", model: model)
    }

    def loading() {
    }

    def map() {
        def model = [:]
        model["selected"] = []

        params.each {
            if (it.value.equals("checked")) {
                model["selected"].add(it.key)
            }
        }

        model["selected"] = model["selected"] as JSON

        render(template: 'map', model: model)
    }

    def keyRatings() {
        int client = params['client'] as Integer
        def keys = JSON.parse(params['selected'] as String)
        Set<String> keySet = new HashSet<String>()
        keys.each {
            keySet.add(it)
        }

        def ratins = JSON.parse(grailsApplication.mainContext.getResource(client+".json").file.text)
        def model = [:]
        def selectedRatings = [:]
        def otherRatings = [:]

        ratins.each {
            if (keySet.contains(it.key)) {
                selectedRatings[it.key] = it.value['avgStarRating']
            } else {
                otherRatings[it.key] = it.value['avgStarRating']
            }
        }

        model['selected'] = selectedRatings
        model['others'] = otherRatings

        render(template: 'keyRatings', model: model)
    }

    def getClientReview() {

        int client = params['client'] as Integer
        BufferedReader fileReader = null;
        LinkedList<String> reviewList = new LinkedList<String>();
        try {
            String line = ""
            fileReader = new BufferedReader(new FileReader(grailsApplication.mainContext.getResource("catfood.csv").file.absolutePath))
            fileReader.readLine()
            int count = 0
            while ((line = fileReader.readLine()) != null) {
                if(count >= 100)
                    break
                String[] tokens = line.split("[,]")
                if (tokens.length > 0) {
                    if(tokens[0].equals(client as String)) {
                        reviewList.add(tokens[9])
                        count ++
                    }
                }
            }
        }
        catch (Exception e) {
            System.out.println("Error in CsvFileReader !!!");
            e.printStackTrace();
        } finally {
            try {
                fileReader.close();
            } catch (IOException e) {
                System.out.println("Error while closing fileReader !!!");
                e.printStackTrace();
            }
        }

        render(template: 'review', model: [reviews:reviewList])
    }

    def getPersonalizedRatings(String fileName, List<String> selectedKeys) {

        ArrayList<Double> numRevsList = new ArrayList<Double>();
        ArrayList<Double> aveStarRatingList = new ArrayList<Double>();
        FileReader reader = new FileReader(grailsApplication.mainContext.getResource(fileName+".json").file.absolutePath);

        JSONParser jsonParser = new JSONParser();
        JSONObject jsonObject = (JSONObject) jsonParser.parse(reader);

        for(String eachKey : selectedKeys) {
            String line = jsonObject.get(eachKey).toString();
            String [] tokens = line.split("[,:}]");
            numRevsList.add(Double.parseDouble(tokens[1]));
            aveStarRatingList.add(Double.parseDouble(tokens[5]));
        }
        double sum = 0;
        for(int i = 0; i<aveStarRatingList.size(); i++) {
            sum += aveStarRatingList.get(i);
        }
        double nonWeightedAve = sum/aveStarRatingList.size();
        double weightedSum = 0;
        double weightedDenomator = 0;
        for(int i = 0; i<aveStarRatingList.size(); i++) {
            weightedSum += aveStarRatingList.get(i) * numRevsList.get(i);
            weightedDenomator += numRevsList.get(i);
        }
        double weightedAve = weightedSum/weightedDenomator;
        def result = [:]
        result['weighted'] = weightedAve
        result['nonweighted'] = nonWeightedAve

        result;
    }
}
