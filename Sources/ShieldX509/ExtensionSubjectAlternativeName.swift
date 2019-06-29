//
//  File.swift
//
//
//  Created by Kevin Wooten on 7/16/19.
//

import Foundation
import PotentASN1
import ShieldOID


public struct SubjectAltName: Equatable, Hashable, ExtensionValue {

  public static let extensionID = iso_itu.ds.certificateExtension.subjectAltName.oid
  public static let asn1Schema = Schemas.SubjectAltName
  public var isCritical: Bool { false }

  public var names: GeneralNames

  public init(names: GeneralNames) {
    self.names = names
  }
}



// MARK: Schemas

public extension Schemas {

  static let SubjectAltName: Schema = GeneralNames

}



extension SubjectAltName: Codable {

  public init(from decoder: Decoder) throws {
    var container = try decoder.unkeyedContainer()
    var names = GeneralNames()
    for _ in 0 ..< (container.count ?? 0) {
      names.append(try container.decode(GeneralName.self))
    }
    self.names = names
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.unkeyedContainer()
    for name in names {
      try container.encode(name)
    }
  }

}
