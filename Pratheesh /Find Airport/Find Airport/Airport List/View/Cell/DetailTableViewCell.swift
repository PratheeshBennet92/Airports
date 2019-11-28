//
//  TableViewCell.swift
//  Find Airport
//
//  Created by 1722885 on 28/11/19.
//  Copyright © 2019 tcs. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    // MARK: - Propery Declaration
    @IBOutlet weak var airportName: UILabel!
    @IBOutlet weak var runwayLength: UILabel!
    @IBOutlet weak var country: UILabel!
    var airport: NearestAirport?{
        didSet{
            configureCell()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // MARK: - UISetup
    private func configureCell(){
        airportName.text = airport?.name
        runwayLength.text = airport?.runwayLength == emptyString || airport?.runwayLength == nil ? notAvailableText : airport?.runwayLength
        country.text = airport?.country
    }
    
}
