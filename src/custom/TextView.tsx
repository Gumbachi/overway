import GObject from "gi://GObject"
import { Gtk, Gdk, Widget, astalify, type ConstructProps } from "astal/gtk3"



// subclass, register, define constructor props
export class TextView extends astalify(Gtk.TextView) {
    static { GObject.registerClass(this) }

    constructor(props: ConstructProps<TextView, Gtk.TextView.ConstructorProps>) {
        super(props as any)
    }
}

// export function CustomTextView() {
//   function setup(view: TextView) {}
//
//   return <TextView
//     className={}
//     setup={setup}
//     editable
//   />
// }
