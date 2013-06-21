SpecTest = @SpecTest = {}

describe 'Mozart.Collection', ->

  beforeEach ->
    Mozart.root = window
    @container = $('<div>').appendTo('body')
    @ele = $('<div>').appendTo(@container)

  afterEach ->
    @container.remove()

  describe 'renders collections of arrays and simple models', ->

    beforeEach ->
      SpecTest.simpleViewFunction = Handlebars.compile('{{#collection collectionObserveBinding="SpecTest.controller.items"}}N:{{content.name}}{{/collection}}', {data:true})
      
      class SpecTest.CollectionTestView extends Mozart.View
        templateFunction: SpecTest.simpleViewFunction
        layout: SpecTest.layout

      SpecTest.layout = Mozart.Layout.create
        rootElement: @ele
        states: [
          Mozart.Route.create
            path: '/customers'
            viewClass: SpecTest.CollectionTestView
        ]
      
      SpecTest.controller = Mozart.MztObject.create({ items: [] })

    afterEach ->
      SpecTest.layout.release()
      SpecTest.controller.release()

    it "should be able to render a simple list from an array", ->
      runs ->
        SpecTest.layout.bindRoot()
        SpecTest.layout.navigateRoute('/customers')

        SpecTest.controller.set('items',[
          {id:1, name:'one'}
          {id:2, name:'two'}
          {id:3, name:'three'}
          {id:4, name:'four'}
        ])

      waits 50
      
      runs ->
        expect(@container.html()).toContain('one')
        expect(@container.html()).toContain('two')
        expect(@container.html()).toContain('three')
        expect(@container.html()).toContain('four')

    it "should be able to render a simple list from an model", ->
      runs ->
        SpecTest.TestItem = Mozart.Model.create
          modelName: 'TestItem'

        SpecTest.TestItem.attributes
          'name': 'string'

        SpecTest.TestItem.createFromValues({name:'five'})
        SpecTest.TestItem.createFromValues({name:'six'})
        SpecTest.TestItem.createFromValues({name:'seven'})

        expect(SpecTest.TestItem.all().length).toEqual(3)

        SpecTest.layout.bindRoot()
        SpecTest.layout.navigateRoute('/customers')

        SpecTest.controller.set('items',SpecTest.TestItem)

      waits 50
      
      runs ->
        expect(@container.html()).toContain('five')
        expect(@container.html()).toContain('six')
        expect(@container.html()).toContain('seven')

      waits 50

      runs ->
        SpecTest.TestItem.createFromValues({name:'eight'})

      waits 50

      runs ->
        expect(@container.html()).toContain('five')
        expect(@container.html()).toContain('six')
        expect(@container.html()).toContain('seven')
        expect(@container.html()).toContain('eight')

  describe 'renders collections of models and submodels', ->

    beforeEach ->
      SpecTest.simpleViewFunction = Handlebars.compile('
        {{#collection collectionObserveBinding="SpecTest.controller.items"}}
          N:{{content.name}}
          {{#collection collectionObserveBinding="content.subitems"}}
            {{content.name}}
          {{/collection}}
        {{/collection}}', {data:true})
      
      class SpecTest.CollectionTestView extends Mozart.View
        templateFunction: SpecTest.simpleViewFunction
        layout: SpecTest.layout

      SpecTest.layout = Mozart.Layout.create
        rootElement: @ele
        states: [
          Mozart.Route.create
            path: '/menu'
            viewClass: SpecTest.CollectionTestView
        ]
      
      SpecTest.controller = Mozart.MztObject.create({ items: [] })

    afterEach ->
      SpecTest.layout.release()
      SpecTest.controller.release()

    it "should be able to render a simple list from an model and relation", ->
      runs ->
        SpecTest.TestItem = Mozart.Model.create
          modelName: 'TestItem'
        SpecTest.TestItem.attributes
          'name': 'string'

        SpecTest.TestSubItem = Mozart.Model.create
          modelName: 'TestSubItem'
        SpecTest.TestSubItem.attributes
          'name': 'string'

        SpecTest.TestItem.hasMany SpecTest.TestSubItem, 'subitems'

        x = SpecTest.TestItem.createFromValues({name:'customers'})
        x.subitems().createFromValues({name:'external'})
        x.subitems().createFromValues({name:'internal'})

        y = SpecTest.TestItem.createFromValues({name:'products'})
        y.subitems().createFromValues({name:'usa'})
        y.subitems().createFromValues({name:'aus'})
        y.subitems().createFromValues({name:'uk'})

        @z = SpecTest.TestItem.createFromValues({name:'coupons'})
        @z.subitems().createFromValues({name:'free'})
        @z.subitems().createFromValues({name:'discount'})
        @z.subitems().createFromValues({name:'buyonegettwo'})
        @z.subitems().createFromValues({name:'buytwogetthree'})

        expect(SpecTest.TestItem.all().length).toEqual(3)

        SpecTest.layout.bindRoot()
        SpecTest.layout.navigateRoute('/menu')

        expect(x.subitems().count()).toEqual(2)
        expect(y.subitems().count()).toEqual(3)
        expect(@z.subitems().count()).toEqual(4)

        SpecTest.controller.set('items',SpecTest.TestItem)

      waits 50
      
      runs ->
        expect(@container.html()).toContain('external')
        expect(@container.html()).toContain('internal')

        expect(@container.html()).toContain('usa')
        expect(@container.html()).toContain('aus')
        expect(@container.html()).toContain('uk')

        expect(@container.html()).toContain('free')
        expect(@container.html()).toContain('discount')
        expect(@container.html()).toContain('buyonegettwo')
        expect(@container.html()).toContain('buytwogetthree')

      waits 50

      runs -> 
        @z.subitems().createFromValues({name:'buyfourgetfive'})

      waits 50
      
      runs ->
        expect(@container.html()).toContain('external')
        expect(@container.html()).toContain('internal')

        expect(@container.html()).toContain('usa')
        expect(@container.html()).toContain('aus')
        expect(@container.html()).toContain('uk')

        expect(@container.html()).toContain('free')
        expect(@container.html()).toContain('discount')
        expect(@container.html()).toContain('buyonegettwo')
        expect(@container.html()).toContain('buytwogetthree')
        expect(@container.html()).toContain('buyfourgetfive')