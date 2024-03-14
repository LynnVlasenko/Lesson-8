//
//  ViewController.swift
//  Lesson8
//
//  Created by Алина Власенко on 14.03.2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func slider(_ sender: UISlider) {
        print(sender)
    }
    // подивитися відео про наступний елемент
    
    // записати про лейери - вони не вміють трекати івенти (і щось було що вони використовують іншу область пам'яті)
    
    //На співбесіді часто питають Як зробити універсальний код і як дженеріки працюють з протоколами
    // мій баг що був з екранами називається screen cicle - (ретайл сайкл? теж щось почула)
// forse unwrapt
//  ПЕРЕДИВИТИСЬ - записати поязнення з тим як працює weak та unowned - є питання на співбесіді
 //   і що таке опшнал під капотом - питьання на співбесіді
    //Associated Types - почитати додатково документацію - прописати код з відти - не копіювати, а саме прописати
    // наприклад одне й те саме для різних вьюшок робится - то можна через дженеріки зробити через Associated Types
    // з нетворкінгом теж використовується - якщо маленька задача, можна не використовувати бібліотеку, а прописати самому і частіше там буде дженеріки. Буде різниця у запитах - різні URL і для запиту даних достатньо буде зробити через дженеріки - вже потім (а які бібліотеки використовуються для виконання нетворкінга?)
    // абстрактні класи в мові свіфт - питання на співьесідті - ні не має, але через протоколи можна щось зробити - послухати ще раз урок
    // доробити з протоколами задачку в кінці - протоколи як колбєк - використання делегатів - продивитися як я робила раніше порівняти чи усе було ок (наче б то так і робила)
    //звернути увагу як використовуються брейк поінти
    // питання на дисптчеризацію свіфт
    
    @IBAction func execute(_ sender: Any) {
//        var a = A() // строннг посилання має // ARC -> a -> +1 reference
//        var b = B() // строннг посилання має // ARC -> a -> +1 reference
//
//        // в Obj-C писали - b.reatin() - додали +1 доя MRC самі
//        a.b = b // ARC -> a -> +1 reference // в такому разі пам'ять не вивільниться - бо об'єкти послалися одне нна одного і ннемає очищення, бо ARC рахує кількість посилань на об'єкт. А тут буде залишається посилання
//        // в Obj-C тут писали - b.release() - додали +1 доя M(Manual)RC самі
//        b.a = a // ARC -> a -> +1 reference //після використанння вік посилання буде +0
//
//       // a = nil - Obj-C MRC
//       // b = nil - Obj-C MRC
//
//        a.fillArray()
//        b.fillArray()
        
//        let secondVC = SecondViewController()
//        secondVC.view.backgroundColor = .green
//
//        present(secondVC, animated: true)
//
//        var responseStrings = APIStringRespone()
//        responseStrings.update(with: ["1", "12", "some string"])
//        responseStrings.date = Date()
//
//        var intResponse = APIIntRespone()
//        intResponse.update(with: [1, 2, 4])
//        intResponse.date = Date()
  
        var stringResponse = APIUniversalResponse<String>()
        stringResponse.update(with: ["1", "12", "some string"])
        stringResponse.date = Date()
        
        var intResponse = APIUniversalResponse<Int>()
        intResponse.update(with: [1, 2, 4])
        intResponse.date = Date()
        
        var doubleResponse = APIDoubleResponse()
        doubleResponse.setup(with: [3.0, 1.4])
        
        //var soneRs: APIResponse = doubleResponse
        
        debugPrint("-> did execute")
        //тут закінчується область видимості для ARC - і тут вінн очищує памєять для a і b (де a = A()  і b = B(), а потім ми записали в змінні класів нижче посиланння на ці об'єкти - і ця память не вивільниться до моменту виходу з області видимості)
    }
}

class SecondViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        debugPrint("SecondViewController -> viewDidAppear")
        doSomeLogic() // тут функція без weak у класі B - буде знову створювати посилання на одне одного як у минулому
    }
    
    deinit {
        debugPrint("SecondViewController -> deinit")
    }
    
    
    func doSomeLogic() {
        var a = A() // строннг посилання має // ARC -> a -> +1 reference
        var b = B() // строннг посилання має // ARC -> a -> +1 reference
        
        // в Obj-C писали - b.reatin() - додали +1 доя MRC самі
        a.b = b // ARC -> a -> +1 reference // в такому разі пам'ять не вивільниться - бо об'єкти послалися одне нна одного і ннемає очищення, бо ARC рахує кількість посилань на об'єкт. А тут буде залишається посилання
        // в Obj-C тут писали - b.release() - додали +1 доя M(Manual)RC самі
        b.a = a // ARC -> a -> +1 reference //після використанння вік посилання буде +0
        
       // a = nil - Obj-C MRC
       // b = nil - Obj-C MRC
        
        a.fillArray()
        b.fillArray()
        
        debugPrint("-> did execute")
    }
}

// init та deinit - зарезервовані функціі для класів - навіть по кольору вони однакові
// class - reference type
class A {
    
    var b: B! //строннг посилання має
    
    init() {
        debugPrint("class A init")
    }
    
    deinit {
        debugPrint("class A deinit")
    }
    
    var imageData1: [Data] = []
    
    func fillArray() {
        for _ in 0 ... 10 {
            let imageData = UIImage(named: "photo_1")?.pngData() ?? Data()
            imageData1.append(imageData)
        }
    }
}

class B {
    
    //var a: A! //строннг посилання має
    weak var a: A!  // робимо слабе посилання - в момент при натисканні кнопки нне буде створюватись +1 посилання вище
    init() {
        debugPrint("class B init")
    }
    
    deinit {
        debugPrint("class B deinit")
    }
    
    var imageData2: [Data] = []
    
    func fillArray() {
        for _ in 0 ... 10 {
            var imageData = UIImage(named: "photo_2")?.pngData() ?? Data()
            imageData2.append(imageData)
        }
    }
}

//Generic - звернути увагу що вони для функцій і типив!

//для задач змінити місцями знначенння у 2 змінних



