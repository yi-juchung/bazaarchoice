package dashboard

import grails.converters.JSON

class MainController {

    def index() {

    }

    def search() {
        render(view:"search")
    }

    def getKeyword() {
        def keywords = JSON.parse(grailsApplication.mainContext.getResource("all.json").file.text)

        def model = ["relatedWords" : keywords.Results]

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

        render(template: 'map', model: model)
    }
}
