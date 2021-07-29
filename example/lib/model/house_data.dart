///
/// Copyright 2021 Wingify Software Pvt. Ltd.
///
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
///
///    http://www.apache.org/licenses/LICENSE-2.0
///
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.


enum Type {
    RESIDENTIAL,
    COMMERCIAL

}
class HouseData {
    int id = 0;
    String name;
    int price;
    int bhk;
    String image;
    Type type = Type.RESIDENTIAL;
    String description = "Apartment for rent";
    String units = "\$";

    HouseData(this.id, this.name, this.price, this.bhk, this.image, {this.type, this.description, this.units});

}