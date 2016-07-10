//
//  FeedImporterDatasourceAEXML.swift
//  Instapod
//
//  Created by Christopher Reitz on 23.03.16.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import Foundation
import AEXML

struct FeedImporterDatasourceAEXML: FeedImporterDatasource {

    var urls: [NSURL]?

    // MARK: - FeedImporterDatasource

    init(data: NSData) {
        do {
            let xml = try AEXMLDocument(xmlData: data)
            urls = [NSURL]()
            if let outlines = xml.root["body"]["outline"].all {
                for outline in outlines {
                    guard let urlString = outline.attributes["xmlUrl"] else { continue }
                    guard let url = NSURL(string: urlString) else { continue }

                    urls!.append(url)
                }
            }
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}
