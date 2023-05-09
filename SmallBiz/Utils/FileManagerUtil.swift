//
//  FileManagerUtil.swift
//  SmallBiz
//
//  Created by Colby Mehmen on 5/3/23.
//

import Foundation

class FileManagerUtil {
    enum Folder: String {
        case employees
        case defaultTask
    }
    
    static let shared = FileManagerUtil()
    
    func getUrl(for folder: Folder) -> URL? {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return url.appendingPathExtension(folder.rawValue)
    }
}
