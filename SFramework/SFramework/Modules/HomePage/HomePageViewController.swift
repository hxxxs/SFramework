//
//  HomePageViewController.swift
//  SFramework
//
//  Created by 123 on 2019/2/27.
//  Copyright © 2019 hxs. All rights reserved.
//

import XSBase

class HomePageViewController: XSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func configUI() {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let vc = XSWebViewController()
        vc.urlString = "https://www.baidu.com"
//        present(vc, animated: true, completion: nil)
        navigationController?.pushViewController(vc, animated: true)
//        navigationController?.pushViewController(ViewController(), animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
