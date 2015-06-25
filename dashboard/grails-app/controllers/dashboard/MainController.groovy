package dashboard

class MainController {

    def index() {

    }

    def search() {
        render(view:"search")
    }

    def getKeyword() {
        def relatedWords = [ 'food', 'vet', 'canned','fish']
        def model = ["relatedWords" : relatedWords]

        render(view:"keywordView", model: model)
    }

    def loading() {
    }

    def map() {
        log.info(params)
        render(template: 'map')
    }
}
